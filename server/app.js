const express=require("express")
const app=express()
const db=require('./db')
const auth=require("./auth/authController")
const product=require("./product/productController")
const order=require("./order/orderController")

app.get("/",(req,res)=>{
    res.status(200).send("You are welcome at Sasto Bazaar")
})

app.use("/product",product)

app.use("/auth",auth)

app.use("/order",order)

port=3000 || process.env.PORT

app.listen(port,()=>{
    console.log(`Server is running at port: ${port}`)
})