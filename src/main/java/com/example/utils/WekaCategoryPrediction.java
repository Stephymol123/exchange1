package com.example.utils;

import weka.core.Instances;
import weka.core.converters.ConverterUtils.DataSource;
import weka.classifiers.Classifier;
import weka.classifiers.Evaluation;
import weka.classifiers.bayes.NaiveBayes;
import weka.core.SerializationHelper;

public class WekaCategoryPrediction {

    public static void main(String[] args) throws Exception {
        // Load dataset
        DataSource source = new DataSource("C:\\Users\\hp\\IdeaProjects\\EXHANGE2\\src\\main\\resources\\data.arff");
        Instances dataset = source.getDataSet();

        // Setting the class attribute (the attribute to predict)
        dataset.setClassIndex(dataset.numAttributes() - 1); // setting category as class attribute

        // Choose a classifier (e.g., NaiveBayes)
        Classifier classifier = new NaiveBayes();

        // Train the model
        classifier.buildClassifier(dataset);

        // Save the trained model
        SerializationHelper.write("C:\\Users\\hp\\IdeaProjects\\EXHANGE2\\src\\main\\resources\\naivebayes_model.model", classifier);

        // Evaluate the model
        Evaluation eval = new Evaluation(dataset);
        eval.crossValidateModel(classifier, dataset, 10, new java.util.Random(1));

        // Output evaluation results
        System.out.println(eval.toSummaryString("\nResults\n======\n", false));
        System.out.println("Confusion Matrix: ");
        double[][] confusionMatrix = eval.confusionMatrix();
        for (double[] row : confusionMatrix) {
            for (double value : row) {
                System.out.print(value + " ");
            }
            System.out.println();
        }
    }
}
