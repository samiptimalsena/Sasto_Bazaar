const mongoose=require("mongoose")

const userSchema=mongoose.Schema({
    name:String,
    email:String,
    password:String
})

mongoose.model("User",userSchema)

module.exports=mongoose.model("User")