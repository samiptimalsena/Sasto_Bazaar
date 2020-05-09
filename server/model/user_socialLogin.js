const mongoose=require("mongoose")

const social_userSchema=mongoose.Schema({
    name:String,
    email:String
})

mongoose.model("Social_Users",social_userSchema)

module.exports=mongoose.model("Social_Users")