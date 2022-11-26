from dotenv import dotenv_values
from pymongo import MongoClient

SECRETS = dotenv_values('.env')

client = MongoClient(SECRETS["MONGO_URL"])
db = client.abot

def prune(var):
    return var if var != -1 else ""

asins = db.asin.find()
with open("asins.csv", "w") as data:
    line = f"roi,fbaFees,new,oosamazon,ooslistprice,avgamazon,avglistprice,productType,avgOfferCount"
    data.write(line)
    data.write("\n")
    for asin_doc in asins:
        print(asin_doc['asin'])
        asin = asin_doc.get('keepa_data')
        if(asin == None):
            continue
        stats = asin.get('stats')
        if(stats == None):
            continue

        roi = round(asin_doc['roi'], 2)

        fbaFees = asin.get('fbaFees')
        if(fbaFees != None):
            fbaFees = fbaFees['pickAndPackFee']
        if(fbaFees == -1 or fbaFees == None):
            fbaFees = 0
        variations = asin.get('variations')
        if(variations != None):
            variations = len(variations)
        if(variations == None):
            variations = 0

        current = stats['current']
        amazon = prune(current[0])
        new = prune(current[1])
        used = prune(current[2])
        listprice = prune(current[4])
        oos = stats['outOfStockPercentage90']
        oosamazon = prune(oos[0])
        oosused = prune(oos[2])
        ooslistprice = prune(oos[4])
        avg180 = stats['avg180']
        avgamazon = prune(avg180[0])
        avgused = prune(avg180[2])
        avglistprice = prune(avg180[4])

        avg365 = stats['avg365']
        avgOfferCount = prune(avg365[11])

        productType = asin['productType']

        line = f"{roi},{fbaFees},{new},{oosamazon},{ooslistprice},{avgamazon},{avglistprice},{productType},{avgOfferCount}"
        data.write(line)
        data.write("\n")
        print(line)
