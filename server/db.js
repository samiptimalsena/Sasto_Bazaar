const mongoose=require("mongoose")

mongoose.connect("mongodb+srv://samip:mongoDB@clusterfirst-ulcep.mongodb.net/test?retryWrites=true&w=majority",
                {useNewUrlParser:true,useUnifiedTopology:true})
                .then(()=>{console.log("DB connected!!")})       