const express=require("express")
const app=express()
const db=require('./db')
const auth=require("./auth/authController")

app.get("/",(req,res)=>{
    res.status(200).send("You are welcome at Sasto Bazaar")
})

app.use("/auth",auth)

port=3000 || process.env.PORT

app.listen(port,()=>{
    console.log(`Server is running at port: ${port}`)
})