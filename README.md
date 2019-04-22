# STATS 5243: Applied Data Science Final Project 

Authors: Yaxin Deng, Xiaomeng Huang, Min Sun, Anderson Nelson 


##  Description: 
The data was scraped from WineEnthusiast on November 22nd, 2017 which contains 13 variables:
Country: The country that the wine is from 
- Description: wine reviews
- Designation: The vineyard within the winery where the grapes that made the wine are from
- Points: The number of points WineEnthusiast rated the wine on a scale of 1-100 (though they say they only post reviews for wines that score >=80)
- Price: The cost for a bottle of the wine
- Province: The province or state that the wine is from
- Region_1: The wine growing area in a province or state (ie Napa)
- Region_2: Sometimes there are more specific regions specified within a wine growing area (ie Rutherford inside the Napa Valley), but this value can sometimes be blank
- Taster_name
- Taster_twitter_handle
- Title: The title of the wine review, which often contains the vintage if you're interested in extracting that feature
- Variety: The type of grapes used to make the wine (ie Pinot Noir)
- Winery: The winery that made the wine

### Approach:
We first plan to do data exploration. We plan to check the quality of description and see if there is any misspelling etc.. Next we plan to do sentiment analysis on the description. Then we will to do a variable selection and build a recommendation system. Finally, we plan to do some data visualizations/dynamic application based on the data and our recommendation results.


## Questions: 

### Step 1: Exploratory Analysis
- How many reviews does each user provide? What percentage of the data has a reviewer?
- Calculate total reviews by country and the percentage distribution? 
- What percentage of the dataset is missing? 
- How many wine designation exist and what is the distribution? 
- Calculate the unique Variety in the dataset? 
- Create a distribution for points and price. Identify any outliers.?
H- ow many Title is in the dataset?  Calculate the total by Titletype?
- Trends analysis 
  - Points distribution by Region, Province, Region_1, Region_2, Title
  - Variety distribution by Region,  Province, Region_1, Region_2, Title

#### Step 2: Cleaning
#### Step 3: Analysis: 
- What are the factors that influence prices?
- What kind of segmentation makes sense for this data
- Create a recommendation system 
- Text analysis of the data 
- Create a model that predicts price and point evaluate based on RMSE
  - Quantify the impact of wine description on price and point? Hypothesis is that description is signficant in predicting points, and not significant when predicting price? 

