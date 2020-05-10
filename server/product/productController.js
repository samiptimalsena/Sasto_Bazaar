const express = require("express")
const router = express.Router()
const bodyParser=require("body-parser")

const Product = require("../model/product")

router.use(bodyParser.json())
router.use(bodyParser.urlencoded({extended:false}))

router.get("/", (req, res) => {
    res.status(200).send("You are at product");
})

router.post("/addProduct", (req, res) => {
    Product.create({
        imageURL: req.body.imageURL,
        price: req.body.price,
        productType: req.body.productType,
        productName: req.body.productName,
        companyName: req.body.companyName,
        gender: req.body.gender,
        default:"product"
    },(err,product)=>{
        if(err) return res.status(500).send("Couldn't add the product")

        res.status(200).send("Product successfully added")
    }
    
    )
})

router.get("/getProduct",(req,res)=>{
    Product.find({default:"product"},
    (err,product)=>{
        if(err) return res.status(500).send("Error on the server")
        res.status(200).send(product)
    })
})

module.exports = router;