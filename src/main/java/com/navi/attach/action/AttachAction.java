/*覆盖原来的文件上传*/

package com.navi.attach.action;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.navi.attach.model.Attach;
import com.navi.attach.model.UploadStatus;
import com.navi.attach.service.AttachService;
import com.navi.org.model.Humres;
import com.navi.org.service.HumresService;
import com.navi.setitem.model.SetItem;
import com.navi.setitem.service.SetItemService;
import com.navi.utils.DateUtils;
import com.navi.utils.FileUtils;
import com.navi.utils.IDGenerator;
import com.navi.utils.SingletonUtils;
import com.navi.utils.StringUtils;
import com.navi.web.AjaxMsg;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.Serializable;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import sun.misc.BASE64Decoder;

@Controller
@RequestMapping({"/attach"})
public class AttachAction {
    private SetItemService setitemService = (SetItemService)SingletonUtils.getSingleton("com.navi.setitem.service.impl.SetItemServiceImpl");
    private AttachService attachService = (AttachService)SingletonUtils.getSingleton("com.navi.attach.service.impl.AttachServiceImpl");
    ObjectMapper mapper = (ObjectMapper)SingletonUtils.getSingleton("com.fasterxml.jackson.databind.ObjectMapper");
    private HumresService humresService = (HumresService)SingletonUtils.getSingleton("com.navi.org.service.impl.HumresServiceImpl");

    public AttachAction() {
    }

    private String getFileDir() {
        SetItem setitem = this.setitemService.getByIdName("navi_file_store_dir");
        return setitem != null && StringUtils.isNotEmpty(setitem.getObjvalue()) ? setitem.getObjvalue() : "D:/NaviSoft/file";
    }

    private String getSwfFileDir() {
        SetItem setitem = this.setitemService.getByIdName("navi_swf_store_dir");
        return setitem != null && StringUtils.isNotEmpty(setitem.getObjvalue()) ? setitem.getObjvalue() : "D:/NaviSoft/swf";
    }

    @RequestMapping({"/view"})
    public ModelAndView view(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String id = req.getParameter("id");
        ModelAndView mav = new ModelAndView("/docbase/fileViewer");
        if (StringUtils.isNotEmpty(id)) {
            Attach attach = (Attach)this.attachService.getById(id);
            String swfDir = attach.getSwfDir();
            int count;
            if (attach.getPageCount() == 0) {
                count = FileUtils.getFileCount(new File(swfDir), ".swf");
                attach.setPageCount(count);
                this.attachService.update(attach);
            } else {
                count = attach.getPageCount();
            }

            if (count <= 0) {
                this.convert(attach.getId());
            }

            mav.addObject("pageCount", count);
            mav.addObject("attach", attach);
        }

        return mav;
    }

    private void convert(String id) {
        Attach attach = (Attach)this.attachService.getById(id);
        if (attach != null) {
            String convertType = this.getConvertType(attach.getObjname());
            if (convertType != null) {
                ;
            }
        }

    }

    @RequestMapping({"/getSwf"})
    public void getSwf(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String id = req.getParameter("id");
        String page = req.getParameter("page");
        OutputStream os = resp.getOutputStream();
        if (StringUtils.isNotEmpty(id)) {
            Attach attach = (Attach)this.attachService.getById(id);
            String swfDir = attach.getSwfDir() + File.separator + page;
            FileUtils.readFile(swfDir, os);
        }

        os.flush();
        os.close();
    }

    @RequestMapping({"/delete"})
    public void delete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String id = req.getParameter("id");
        if (StringUtils.isNotEmpty(id)) {
            this.attachService.delete(id);
        }

        PrintWriter out = resp.getWriter();
        out.print("ok");
        out.close();
    }

    @RequestMapping({"/uploadImg"})
    public void uploadImg(HttpServletRequest req, HttpServletResponse resp) {
        String uploadPath = req.getSession().getServletContext().getRealPath("/") + "/upload";
        String fileDir = this.getFileDir();
        String bufferDir = fileDir + "/buffer";
        File buffer = new File(bufferDir);
        if (!buffer.exists()) {
            FileUtils.makeDir(bufferDir);
        }

        DiskFileItemFactory factory = new DiskFileItemFactory();
        factory.setRepository(buffer);
        factory.setSizeThreshold(2097152);
        ServletFileUpload upload = new ServletFileUpload(factory);

        try {
            List<FileItem> fileItemList = upload.parseRequest(req);
            Iterator fileItems = fileItemList.iterator();

            while(true) {
                while(true) {
                    FileItem fileItem;
                    String fileName;
                    do {
                        do {
                            if (!fileItems.hasNext()) {
                                return;
                            }

                            fileItem = (FileItem)fileItems.next();
                        } while(fileItem.isFormField());

                        fileName = fileItem.getName().substring(fileItem.getName().lastIndexOf("\\") + 1);
                    } while(StringUtils.isEmpty(fileName));

                    String uuid;
                    if (!fileName.endsWith(".gif") && !fileName.endsWith(".png") && !fileName.endsWith(".jpg") && !fileName.endsWith(".jpeg") && !fileName.endsWith(".avi") && !fileName.endsWith(".flv") && !fileName.endsWith(".wmv") && !fileName.endsWith(".mp3") && !fileName.endsWith(".rm") && !fileName.endsWith(".rmvb") && !fileName.endsWith(".mkv")) {
                        AjaxMsg m = new AjaxMsg(0, "不支持此类文件的上传！");
                        uuid = this.mapper.writeValueAsString(m);
                        PrintWriter out = resp.getWriter();
                        out.print(uuid);
                        out.close();
                    } else {
                        String storeDir = uploadPath + File.separator + FileUtils.getRandomDir();
                        uuid = IDGenerator.getUUID();
                        String filePath = storeDir + File.separator + uuid;
                        FileUtils.makeNewFile(filePath);
                        File file = new File(filePath);
                        fileItem.write(file);
                        Attach attach = new Attach();
                        attach.setObjname(fileName);
                        attach.setCreateTime(DateUtils.getCurrentDateTime());
                        attach.setFilePath(filePath);
                        attach.setFileSize(fileItem.getSize());
                        Serializable id = this.attachService.save(attach);
                        Map<String, Object> jo = new HashMap();
                        jo.put("error", 0);
                        jo.put("filename", fileName);
                        jo.put("id", attach.getId());
                        jo.put("url", req.getContextPath() + "/attach/showPicture.do?id=" + id);
                        resp.setCharacterEncoding("utf-8");
                        String json = this.mapper.writeValueAsString(jo);
                        PrintWriter out = resp.getWriter();
                        out.print(json);
                        out.close();
                    }
                }
            }
        } catch (Exception var22) {
            ;
        }
    }

    @RequestMapping({"/upload"})
    public void upload(HttpServletRequest req, HttpServletResponse resp) {
        String fileDir = this.getFileDir();
        String swfDir = this.getSwfFileDir();
        String bufferDir = fileDir + "/buffer";
        String listenerId = req.getParameter("listenerId");
        File buffer = new File(bufferDir);
        if (!buffer.exists()) {
            FileUtils.makeDir(bufferDir);
        }

        DiskFileItemFactory factory = new DiskFileItemFactory();
        factory.setRepository(buffer);
        factory.setSizeThreshold(2097152);
        FileUploadListener uploadListener = new FileUploadListener(req);
        ServletFileUpload upload = new ServletFileUpload(factory);
        upload.setProgressListener(uploadListener);

        try {
            List<FileItem> fileItemList = upload.parseRequest(req);
            Iterator fileItems = fileItemList.iterator();

            while(fileItems.hasNext()) {
                FileItem fileItem = (FileItem)fileItems.next();
                if (!fileItem.isFormField()) {
                    String fileName = fileItem.getName().substring(fileItem.getName().lastIndexOf("\\") + 1);
                    if (!StringUtils.isEmpty(fileName)) {
                        String randomDir = FileUtils.getRandomDir();
                        String uuid = IDGenerator.getUUID();
                        String filePath = fileDir + File.separator + randomDir + File.separator + uuid;
                        swfDir = swfDir + File.separator + randomDir + File.separator + uuid;
                        FileUtils.makeNewFile(filePath);
                        File file = new File(filePath);
                        fileItem.write(file);
                        String fileType = this.getFileType(fileName);
                        Attach attach = new Attach();
                        attach.setObjname(fileName);
                        attach.setCreateTime(DateUtils.getCurrentDateTime());
                        attach.setFilePath(file.getAbsolutePath());
                        attach.setSwfDir((new File(swfDir)).getAbsolutePath());
                        attach.setFileSize(fileItem.getSize());
                        attach.setFileType(fileType);
                        this.attachService.save(attach);
                        this.convert(attach.getId());
                        req.getSession().setAttribute("attach_" + listenerId, attach);
                    }
                }
            }
        } catch (FileUploadException var25) {
            var25.printStackTrace();
        } catch (Exception var26) {
            var26.printStackTrace();
        } finally {
            FileUtils.deleteDir(bufferDir);
        }

    }

    private String getFileType(String fileName) {
        fileName = StringUtils.toLowerCase(fileName);
        if (!fileName.endsWith(".doc") && !fileName.endsWith(".docx")) {
            if (!fileName.endsWith(".ppt") && !fileName.endsWith(".pptx")) {
                if (!fileName.endsWith(".xls") && !fileName.endsWith(".xlsx")) {
                    return fileName.indexOf(".") != -1 ? fileName.substring(fileName.lastIndexOf(".") + 1) : null;
                } else {
                    return "xls";
                }
            } else {
                return "ppt";
            }
        } else {
            return "doc";
        }
    }

    private String getConvertType(String fileName) {
        fileName = StringUtils.toLowerCase(fileName);
        return null;
    }

    @RequestMapping({"/showPicture"})
    public void showPicture(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String id = req.getParameter("id");
        String size = req.getParameter("size");
        Attach attach = (Attach)this.attachService.getById(id);
        if (attach != null) {
            String filePath = attach.getFilePath();
            if (size != null) {
                filePath = filePath.replace("_b", "_" + size);
            }

            File file = new File(filePath);
            if (!file.exists() && !filePath.endsWith("_b")) {
                file = new File(attach.getFilePath());
                if (!file.exists()) {
                    return;
                }
            }

            resp.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(attach.getObjname(), "UTF-8"));
            resp.setContentType(FileUtils.getMimeType(attach.getObjname()));
            resp.setCharacterEncoding("GBK");
            ServletOutputStream os = resp.getOutputStream();
            FileUtils.readFile(file.getAbsolutePath(), os);
            os.flush();
            os.close();
        }
    }

    @RequestMapping({"/getUploadStatus"})
    public void getStatus(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        String listenerId = req.getParameter("listenerId");
        UploadStatus status = (UploadStatus)session.getAttribute("status_" + listenerId);
        if (status != null) {
            if (status.getBytesRead() >= status.getFileSize()) {
                Attach attach = (Attach)session.getAttribute("attach_" + listenerId);
                if (attach != null) {
                    status.setAttachId(attach.getId());
                    status.setAttachName(attach.getObjname());
                    session.setAttribute("attach_" + listenerId, (Object)null);
                }
            } else {
                status.setAttachId((String)null);
                status.setAttachName((String)null);
            }
        }

        resp.reset();
        resp.setCharacterEncoding("UTF-8");
        PrintWriter out = resp.getWriter();
        String json = this.mapper.writeValueAsString(status);
        out.print(json);
        out.close();
    }

    @RequestMapping({"/imageClippingUI"})
    public ModelAndView imageClippingUI(HttpServletRequest req) {
        ModelAndView mav = new ModelAndView("/attach/imageClipping");
        Humres humres = (Humres)this.humresService.getById(req.getParameter("humresId"));
        mav.addObject("humres", humres);
        return mav;
    }

    @RequestMapping({"/imageClipping"})
    public void imageClipping(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String pic162 = req.getParameter("pic1");
        String pic48 = req.getParameter("pic2");
        String pic20 = req.getParameter("pic3");
        String humresId = req.getParameter("humresId");
        Humres humres = (Humres)this.humresService.getById(humresId);
        String filePath = "";
        String image = humres.getImage();
        Attach attach = (Attach)this.attachService.getById(image);
        if (!StringUtils.isEmpty(image) && attach != null) {
            filePath = attach.getFilePath();
            if (filePath.endsWith("_b")) {
                filePath = filePath.substring(0, filePath.length() - 2);
            }
        } else {
            String uuid = IDGenerator.getUUID();
            String storeDir = req.getServletContext().getRealPath("/") + File.separator + FileUtils.getRandomDir();
            filePath = storeDir + File.separator + uuid;
            attach = new Attach();
            attach.setObjname(humres.getObjname() + ".jpg");
            attach.setCreateTime(DateUtils.getCurrentDateTime());
            attach.setFilePath(filePath + "_b");
            this.attachService.save(attach);
        }

        this.saveImageClippingFile(filePath + "_b", pic162);
        this.saveImageClippingFile(filePath + "_m", pic48);
        this.saveImageClippingFile(filePath + "_s", pic20);
        humres.setImage(attach.getId());
        this.humresService.update(humres);
        PrintWriter out = resp.getWriter();
        out.println("{status:1,attachId:\"" + attach.getId() + "\"}");
        out.close();
    }

    private void saveImageClippingFile(String filePath, String pic) {
        if (StringUtils.isNotEmpty(pic)) {
            FileUtils.makeNewFile(filePath);
            File file = new File(filePath);

            try {
                FileOutputStream fos = new FileOutputStream(file);
                fos.write((new BASE64Decoder()).decodeBuffer(pic));
                fos.close();
            } catch (FileNotFoundException var5) {
                var5.printStackTrace();
            } catch (IOException var6) {
                var6.printStackTrace();
            }
        }

    }

    /*返回图片信息的上传接口*/
    @RequestMapping({"/uploadImgByEdit"})
    @ResponseBody
    public Map uploadImgByEdit(HttpServletRequest req, HttpServletResponse resp) {
        Map resultMap = new HashMap<>();
        String imgId="";

        String fileDir = this.getFileDir();
        String swfDir = this.getSwfFileDir();
        String bufferDir = fileDir + "/buffer";
        String listenerId = req.getParameter("listenerId");
        File buffer = new File(bufferDir);
        if (!buffer.exists()) {
            FileUtils.makeDir(bufferDir);
        }

        DiskFileItemFactory factory = new DiskFileItemFactory();
        factory.setRepository(buffer);
        factory.setSizeThreshold(2097152);
        FileUploadListener uploadListener = new FileUploadListener(req);
        ServletFileUpload upload = new ServletFileUpload(factory);
        upload.setProgressListener(uploadListener);

        try {
            List<FileItem> fileItemList = upload.parseRequest(req);
            Iterator fileItems = fileItemList.iterator();

            while(fileItems.hasNext()) {
                FileItem fileItem = (FileItem)fileItems.next();
                if (!fileItem.isFormField()) {
                    String fileName = fileItem.getName().substring(fileItem.getName().lastIndexOf("\\") + 1);
                    if (!StringUtils.isEmpty(fileName)) {
                        String randomDir = FileUtils.getRandomDir();
                        String uuid = IDGenerator.getUUID();
                        String filePath = fileDir + File.separator + randomDir + File.separator + uuid;
                        swfDir = swfDir + File.separator + randomDir + File.separator + uuid;
                        FileUtils.makeNewFile(filePath);
                        File file = new File(filePath);
                        fileItem.write(file);
                        String fileType = this.getFileType(fileName);
                        Attach attach = new Attach();
                        attach.setObjname(fileName);
                        attach.setCreateTime(DateUtils.getCurrentDateTime());
                        attach.setFilePath(file.getAbsolutePath());
                        attach.setSwfDir((new File(swfDir)).getAbsolutePath());
                        attach.setFileSize(fileItem.getSize());
                        attach.setFileType(fileType);
                        this.attachService.save(attach);
                        this.convert(attach.getId());
                        imgId =attach.getId();
                        req.getSession().setAttribute("attach_" + listenerId, attach);

                        //封装图片信息
                        resultMap.put("error", 0);
                        resultMap.put("url",imgId);
                    }
                }
            }
        } catch (FileUploadException var25) {
            var25.printStackTrace();
            resultMap.put("error", 1);
            resultMap.put("message", "文件上传失败");
        } catch (Exception var26) {
            var26.printStackTrace();
            resultMap.put("error", 1);
            resultMap.put("message", "文件上传失败");
        } finally {
            FileUtils.deleteDir(bufferDir);

            return resultMap;
        }



    }
}
