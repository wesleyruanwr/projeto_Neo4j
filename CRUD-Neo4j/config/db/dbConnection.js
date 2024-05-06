const neo4j = require('neo4j-driver');

const dbConnection = async () => {

const URI = process.env.URI;
const USER = process.env.USER;
const PASSWORD = process.env.PASSWORD; 

try {

const driver = neo4j.driver(URI, neo4j.auth.basic(USER, PASSWORD));

const serverInfo = await driver.getServerInfo();
console.log(`Conexão com o banco estabelecida com sucesso.`);
console.log(serverInfo)

} catch (err) {
  console.log(`Ocorreu o erro ${err}`)
}

}


module.exports = dbConnection