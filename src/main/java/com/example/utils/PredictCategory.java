package com.example.utils;

import weka.core.Attribute;
import weka.core.DenseInstance;
import weka.core.Instance;
import weka.core.Instances;
import weka.core.SerializationHelper;
import weka.classifiers.Classifier;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;

@WebServlet("/predictCategory")
public class PredictCategory extends HttpServlet {

    private Classifier classifier;

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            // Load the trained model when the servlet is initialized
            classifier = (Classifier) SerializationHelper.read("C:\\Users\\hp\\IdeaProjects\\EXHANGE2\\src\\main\\resources\\naivebayes_model.model");
        } catch (Exception e) {
            throw new ServletException("Failed to load the model", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Forward the request to the JSP page with the form
        req.getRequestDispatcher("/predict.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Get input values from the request
        String brand = req.getParameter("brand");
        String model = req.getParameter("model");
        String type = req.getParameter("type");
        String colour = req.getParameter("colour");
        String ram = req.getParameter("ram");
        String size = req.getParameter("size");

        String predictedCategory = null;

        try {
            // Create attributes based on your ARFF file structure
            ArrayList<Attribute> attributes = new ArrayList<>(Arrays.asList(
                    new Attribute("Brand", Arrays.asList("Lenovo", "Samsung", "Apple", "Microsoft", "Zara", "IKEA", "Toshiba", "Bose", "Google", "Acer", "Panasonic", "Crayola", "Puma", "Bosch", "Reebok", "None")),
                    new Attribute("Model", Arrays.asList("Pixel_6_Pro", "XPS_13", "15_Pro", "Surface_Pro_8", "QuietComfort_45", "Chromebook_Flip", "ThinkPad_X1", "Nitro_5", "InstaView", "None")),
                    new Attribute("Type", Arrays.asList("Sofa", "Desktop", "Tablet", "Chair", "Skirt", "Desk", "Jacket", "Phone", "Dishwasher", "Refrigerator", "Smartwatch", "Speaker", "Microwave", "None")),
                    new Attribute("Colour", Arrays.asList("Green", "Purple", "White", "Orange", "Black", "Magenta", "Teal", "Coral", "Bronze", "None")),
                    new Attribute("RAM", Arrays.asList("4GB", "12GB", "128GB", "24GB", "None")),
                    new Attribute("Size", Arrays.asList("XS", "S", "M", "XXL", "None")),
                    new Attribute("Category", Arrays.asList("Clothing", "Electronics", "Furniture"))
            ));

            // Create an empty dataset with the attributes
            Instances dataSet = new Instances("TestInstances", attributes, 0);
            dataSet.setClassIndex(dataSet.numAttributes() - 1); // Set the category attribute as the class

            // Create an instance with the user input
            Instance instance = new DenseInstance(dataSet.numAttributes());
            instance.setValue(attributes.get(0), brand);
            instance.setValue(attributes.get(1), model);
            instance.setValue(attributes.get(2), type);
            instance.setValue(attributes.get(3), colour);
            instance.setValue(attributes.get(4), ram != null ? ram : "None");
            instance.setValue(attributes.get(5), size != null ? size : "None");

            // Add the instance to the dataset
            dataSet.add(instance);

            // Predict the category
            double predictedIndex = classifier.classifyInstance(dataSet.firstInstance());
            predictedCategory = dataSet.classAttribute().value((int) predictedIndex);

        } catch (Exception e) {
            throw new ServletException("Error during prediction", e);
        }

        // Forward the result to the JSP page
        req.setAttribute("predictedCategory", predictedCategory);
        req.getRequestDispatcher("/predict.jsp").forward(req, resp);
    }
}