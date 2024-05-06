const neo4j = require('neo4j-driver');

const driver = neo4j.driver("bolt://localhost:7687", neo4j.auth.basic("neo4j", "neo4j2024"));

const actorController = {

  // cria um novo ator 
  create: async (req, res) => {
    const session = driver.session();
    try {
      const name = req.body.name;
      const result = await session.run(
        `MERGE (a:Actor {actor_name: "${name}"}) RETURN a`
      );

      const response = {
        records: result.records,
      };

      res.status(201).json({ response, msg: "Ator criado com sucesso." });
    } catch (error) {
      console.log(error);
      res.status(500).json({ msg: "Não foi possível realizar a criação do ator." });
    } finally {
      if (session) await session.close();
    }
  },

  // busca o ator pelo nome
  getActorByName: async (req, res) => {
    const session = driver.session();
    try {
      const name = req.query.name

      if (!name || name === 'undefined') {
        return res.status(403).json({ msg: "O parâmetro solicitado não se encontra na requisição." })
      }

      const result = await session.run(
        `MATCH (a:Actor {actor_name: "${name}"}) RETURN a`
      );
      if (result.records.length === 0) {
        return res.status(404).json({ msg: "ator não encontrado." });
      }

      const response = {
        records: result.records,
      };

      res.status(200).json({ response, msg: "Ator encontrado com sucesso." });

    } catch (error) {
      console.log(error);
      res.status(500).json({ msg: "Não foi possível realizar a busca." });
    }
    finally {
      if (session) await session.close();
    }
  },

  // busca um conjunto de atores com a quantia determinada nos parâmetros da requisição.
  getAllActorsInRange: async (req, res) => {
    const session = driver.session()
    try {
      const range = req.query.range

      if (!range || range === 'undefined') {
        const result = await session.run(
          `MATCH (a:Actor) RETURN a LIMIT 20`
        )
        const response = {
          records: result.records,
        };
        return res.status(200).json({ response, msg: "Usuários retornados com sucesso." })
      }
      const query = `MATCH (a:Actor) RETURN a LIMIT ${range}`
      const result = await session.run(query)

      const response = {
        records: result.records,
      };
      res.status(200).json({ response, msg: "Usuários retornados com sucesso." })

    } catch (error) {
      console.log(error);
      res.status(500).json({ msg: "Não foi possível realizar a busca." });
    }
    finally {
      if (session) await session.close();
    }
  },

  // busca os filmes que um determinado ator participou.
  getFilmsActorRel: async (req, res) => {
    const session = driver.session()
    try {
      const { name, range } = req.body

      if (!name || name === 'undefined') {
        return res.status(400).json({ msg: "Não foi possível obter nenhum dado da requisição." })
      }
      if (!range || range === 'undefined') {
        await session.run(`MATCH (a:Actor {actor_name: "${name}"})<-[r:HAS_CAST]-(s:ShowCatalog) RETURN a, r, s`)
        const response = {
          records: result.records,
        };
        res.status(200).json({ response, msg: "Busca concluída com sucesso." });
      }
      const query = `MATCH (a:Actor {actor_name: "${name}"})<-[r:HAS_CAST]-(s:ShowCatalog) RETURN a, r, s LIMIT ${range}`
      const result = await session.run(query)

      const response = {
        records: result.records,
      };
      res.status(200).json({ response, msg: "Busca concluída com sucesso." });


    } catch (error) {
      console.log(error);
      res.status(500).json({ msg: "Não foi possível realizar a busca." });
    } finally {
      if (session) await session.close();
    }
  },

  update: async (req, res) => {
    const session = driver.session()
    try {
      const { name, newName } = req.body;

      if (!name || name === 'undefined' || !newName || newName === 'undefined') {
        return res.status(403).json({ msg: "um dos parâmetros não foi informado." })
      }
      const query = `MATCH (a:Actor) 
                    WHERE a.actor_name = "${name}"
                    SET a.actor_name = "${newName}" 
                    RETURN a`
      const result = await session.run(query)

      const response = {
        records: result.records,
      };

      res.status(201).json({ response, msg: "Ator atualizado com sucesso." })


    } catch (error) {
      console.log(error);
      res.status(500).json({ msg: "Não foi possível realizar a busca." });
    } finally {
      if (session) await session.close();
    }
  },

  // apaga um registro
  delete: async (req, res) => {
    const session = driver.session();
    try {
      const name = req.query.name;
      if (!name || name === 'undefined') {
        return res.status(404).json({ msg: "Ator não encontrado." })
      }
      const query = `MATCH(a:Actor)
      WHERE a.actor_name = "${name}"
      DELETE a RETURN a`
      const result = await session.run(query)
      const response = {
        records: result.records,
      }
      res.status(200).json({ response, msg: "ator apagado com sucesso." })

    } catch (error) {
      console.log(error);
      res.status(500).json({ msg: "Não foi possível realizar a busca." });
    } finally {
      if (session) await session.close();
    }
  }

};

module.exports = actorController;
