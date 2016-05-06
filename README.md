# genericClassifier
R package to perform support vector machine classification of high throughput gene expression data with an MRMR identified feature set.

The R package genericClassifier includes a set of functions for training and testing a support vector machine model (from the R package e1071) based on a features identified by the Maximum Relevance Minimum Redundance algorithm  (from the R package mRMRe). The purpose of the package is to obtain a predictive classifier based on high throughput gene expression data.

## Installation

You can install the latest version from Github

```s
install.packages("devtools")
library(devtools)
install_github("thomasw23/genericClassifier") 
```

## Usage

```s
library(genericClassifier)
```

```s
# load training and validation data
data(genericClassifierData)
```

```s
# test a range of feature set sizes generated by MRMR using the training data
# the output is a list of 3 elements: element 1 is a list of probe ids for each 
# feature set, element 2 is a vector of the accuracies of each feature set, and 
# element 3 is a list of txClassifier objects for each feature set.
train_range_test_output <- createClassifier(data=train_data, comp_type=c("C","A"), 
					    typeK="range", range_pars=c("full",5,20,5))
```

```s
# test a range of cost and gamma values for the optimal feature set size
costs <- c(1,2,3,10,20,30,100,200,300)
gammas <- c(0.1, 0.01, 0.001, 0.0001, 0.00001)
train_cost_gamma_test_output <- do.call(cbind, lapply(costs, function(x) {
	unlist(lapply(gammas, function(y) {
		crossValidateClassifier(train_range_test_output[[3]][[1]]$data, 
					num_iter="full", svm_cost=x, svm_gamma=y) 
}))}))
colnames(train_cost_gamma_test_output) <- costs
rownames(train_cost_gamma_test_output) <- gammas
```
 
 ```s
# create a list to hold trained classifier object
trainingClassifier <- list()
# use the optimal feature set and svm parameters to train a classifier object
createClassifier(data=train_data, comp_type=c("C","A"), typeK="set", range_pars=c("full", 5), 
		classifier_name="trainingClassifier", svm_cost=3, svm_gamma=0.01)
```

```s
# calculate Leave One Out Cross Validation accuracy of training data with testClassification function
testClassification(data_prefix=train_data, calc_ts_overall_accuracy=TRUE,
		   classifier_name="trainingClassifier", id_data=train_pheno)
```

```s
# test validation data
testClassification(data_prefix=validation_data, classifier_name="trainingClassifier")		
```
