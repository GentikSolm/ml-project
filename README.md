# ML-Project

Final Project for Mimoto's ML Class

Data hosted at [ml.brunuslabs.com](https://ml.brunuslabs.com)

### Introduction to Dataset

This projects objective is to use different machine learning models
to determine a given products return on investment if purchased for resale
from amazon given different attributes.

This data was gathered over time from AmazonBot, a bot made by Brunus Labs for a customer.

This is a Regression model, as our response variable is the return on investment percentage.

This is also a inference model, since we know the ROI at a given price, but want to find out
the variable relationship

### Summary and Info


Total records
- 12781

Response Variable
- Return on Investment (roi)

Independent Variables

| Variable | Description | Class |
|-------|------|-------|
| fbafees | Fees associated with reselling on amazon | Numeric |
| newprice | Current new price of product | Numeric |
| oosamazon | Amazon out of stock percentage | Numeric |
| ooslistprice | List price out of stock percentage | Numeric |
| avgamazon | 180 day average amazon price | Numeric |
| avglistprice | 180 day average list price | Numeric |
| newPriceIsMap | If the current price is MAP price | Boolean |
| isAdultProduct | If the product is an adult product | Boolean |
| productType | The type of the product | Categorical |


# Product Types

Values for productType

| Key | Value |
|---|-------------|
| 0 | Standard |
| 1 | Downloadable |
| 2 | EBook |
| 3 | Inaccessable |
| 4 | Invalid |
| 5 | Variation Parent |

