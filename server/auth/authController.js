const express = require("express")
const router = express.Router()
const bodyParser = require("body-parser")

const User = require("../model/user")

const jwt = require('jsonwebtoken')
const bcrypt = require('bcryptjs')
const config = require('../config')

router.use(bodyParser.json())
router.use(bodyParser.urlencoded({ extended: false }))


router.get('/', (req, res) => {
    res.status(200).send("You are at authentication")
})

router.post('/register', (req, res) => {
    var hashedPassword = bcrypt.hashSync(req.body.password, 8)

    User.findOne({ email: req.body.email }, (err, user) => {
        if (err) return res.status(500).send("Error on the server")
        if (user) return res.send({ auth: false, token: null })

        if (!user) {
            User.create({
                name: req.body.name,
                email: req.body.email,
                password: hashedPassword
            },
                (err, user) => {
                    if (err) return res.status(500).send("There was problem registering the user")

                    var token = jwt.sign({ id: user._id }, config.secret, {
                        expiresIn: 86400
                    })

                    res.status(200).send({ auth: true, token: token })
                }
            )
        }
    })
})

router.post('/login', (req, res) => {
    User.findOne({ email: req.body.email }, (err, user) => {
        if (err) return res.status(500).send("Error on the server")

        if (!user) return res.status(404).send("No user found")

        var passwordIsValid = bcrypt.compareSync(req.body.password, user.password)

        if (!passwordIsValid) return res.status(401).send({ auth: false, token: null })

        var token = jwt.sign({ id: user._id }, config.secret, {
            expiresIn: 86400
        });
        res.status(200).send({ auth: true, token: token })
    })
})

module.exports = router