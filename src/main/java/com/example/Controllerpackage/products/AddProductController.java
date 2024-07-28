package com.example.Controllerpackage.products;

import com.example.Beanpackage.CategoryBeanCls;
import com.example.Daopackage.CategoryDAO;
import com.example.Beanpackage.ProductBeanCls;
import com.example.Daopackage.ProductDAO;
import com.example.Beanpackage.Beancls;
import com.example.utils.CloudinaryConfig;
import com.example.utils.DatabaseConnection;
import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@WebServlet("/addProduct")
public class AddProductController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;
    private Cloudinary cloudinary;

    @Override
    public void init() {
        productDAO = new ProductDAO();
        categoryDAO = new CategoryDAO();
        cloudinary = CloudinaryConfig.getCloudinary();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        addProduct(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        List<CategoryBeanCls> categories = categoryDAO.selectAllCategories();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/user-add-item.jsp").forward(request, response);
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Beancls user = (Beancls) session.getAttribute("user");
        int userId = user.getId();

        ProductBeanCls newProduct = new ProductBeanCls();
        List<String> imageUrls = new ArrayList<>();

        if (ServletFileUpload.isMultipartContent(request)) {
            try {
                FileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);
                List<FileItem> items = upload.parseRequest(request);

                for (FileItem item : items) {
                    if (item.isFormField()) {
                        processFormField(item, newProduct);
                    } else {
                        String imageUrl = uploadImageToCloudinary(item);
                        imageUrls.add("\"" + imageUrl + "\"");
                    }
                }

                newProduct.setUser_id(userId);
                newProduct.setPimages(String.join(",", imageUrls));

                try (Connection connection = DatabaseConnection.connect()) {
                    productDAO.insertProduct(connection, newProduct);
                } catch (SQLException e) {
                    throw new ServletException("Database error: " + e.getMessage(), e);
                }

                response.sendRedirect("success.jsp");
            } catch (Exception e) {
                throw new ServletException("File upload error: " + e.getMessage(), e);
            }
        } else {
            throw new ServletException("Form must be multipart/form-data");
        }
    }

    private void processFormField(FileItem item, ProductBeanCls product) {
        String fieldName = item.getFieldName();
        String fieldValue = item.getString();

        switch (fieldName) {
            case "pname":
                product.setPname(fieldValue);
                break;
            case "price":
                product.setPrice(Double.parseDouble(fieldValue));
                break;
            case "description":
                product.setDescription(fieldValue);
                break;
            case "quantity":
                product.setQuantity(Integer.parseInt(fieldValue));
                break;
            case "category_id":
                product.setCategory_id(Integer.parseInt(fieldValue));
                break;
        }
    }

    private String uploadImageToCloudinary(FileItem item) throws IOException, ServletException {
        byte[] fileBytes = inputStreamToByteArray(item.getInputStream());
        String fileName = UUID.randomUUID().toString() + "-" + item.getName();

        Map<String, Object> uploadResult;
        try {
            uploadResult = cloudinary.uploader().upload(fileBytes, ObjectUtils.asMap(
                    "public_id", fileName,
                    "resource_type", "auto"
            ));
        } catch (Exception e) {
            throw new ServletException("Cloudinary upload error: " + e.getMessage(), e);
        }

        return (String) uploadResult.get("secure_url");
    }

    private byte[] inputStreamToByteArray(InputStream inputStream) throws IOException {
        try (ByteArrayOutputStream buffer = new ByteArrayOutputStream()) {
            int nRead;
            byte[] data = new byte[16384];
            while ((nRead = inputStream.read(data, 0, data.length)) != -1) {
                buffer.write(data, 0, nRead);
            }
            buffer.flush();
            return buffer.toByteArray();
        }
    }
}