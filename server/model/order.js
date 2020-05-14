const mongoose=require("mongoose")

const orderSchema=mongoose.Schema({
    productName:String,
    userName:String,
    phoneNo: String,
    address: String
})

mongoose.model("Orders",orderSchema)

module.exports=mongoose.model("Orders")