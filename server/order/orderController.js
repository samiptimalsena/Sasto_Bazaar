const express=require("express")
const bodyParser=require("body-parser")
const Order=require("../model/order")

const router=express.Router()

router.use(bodyParser.json())

router.use(bodyParser.urlencoded({extended:true}))

router.get("/",(req,res)=>{
    res.status(200).send("You are at order")
})

router.post("/addOrder",(req,res)=>{
    Order.create({
       productName:req.body.productName,
       userName:req.body.userName,
       phoneNo:req.body.phoneNo,
       address:req.body.address 
    },
    (err,order)=>{
        if(err) return res.stayus(500).send("error on the server")
        res.status(200).send({message:"Order successfully placed"})
    }
    )
})

module.exports=router;