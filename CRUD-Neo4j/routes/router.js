const router = require('express').Router()
const actorRouter = require('./actor');

router.use('/', actorRouter)

module.exports = router;