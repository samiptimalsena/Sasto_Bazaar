const mongoose=require("mongoose")

const productSchema=mongoose.Schema({
    imageURL:String,
    price:String,
    productType:String,
    productName:String,
    companyName:String,
    gender:String,
    default:String
})

mongoose.model("Product",productSchema)

module.exports=mongoose.model("Product")