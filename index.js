//Server
const express = require("express");
const app = express();

//Dependences
const lib = require("./Network/MyLib");
const q = require("./Network/queries");

//MIDDLEWARES_________________________________
app.use(express.json());
//Verify Token/Login
app.use((req, res, next) => {
    try {
        const pathRequest = req.path;
        const headerauthorization = req.headers.authorization;

        if (pathRequest === '/resto.com/singUp' || pathRequest === '/resto.com/singIn') { return next(); } else {
            const user = lib.DecoToken(headerauthorization);
            if (user) { next(); } else { throw `user without registration`; }
        }
    } catch (error) { res.status(400);
        res.json({ error }); }
});
//USUARIOS____________________________________
app.post('/resto.com/singIn', async(req, res) => {
    try {
        await q.SingIn(req.body);
        res.status(201);
        res.json({});
    } catch (error) { res.status(400);
        res.json({ error }); };
});
app.post('/resto.com/singUp', async(req, res) => {
    try {
        const userInfo = await q.SingUp(req.body);
        res.status(200);
        res.json(userInfo);
    } catch (error) { res.status(400);
        res.json({ error }); };
});
app.get('/resto.com/usuarios', async(req, res) => {
    try {
        const user = await q.UserInfo(req.headers.authorization);
        res.status(200);
        res.json(user);
    } catch (error) { res.status(500);
        res.json({ error }); }
});
//CRUD PRODUCTOS________________________________
app.get('/resto.com/productos', async(req, res) => {
    try {
        items = await q.GetProducts();
        if (items.length === 0) { res.status(204);
            res.json(items); } else { res.status(200);
            res.json(items); }
    } catch (error) { res.status(500);
        res.json({ error }); };
});
app.get('/resto.com/productos/:id', async(req, res) => {
    try {
        const items = await q.GetProductsByID(req.params.id);
        res.status(200);
        res.json(items);
    } catch (error) { res.status(404);
        res.json({ error }); };
});
app.post('/resto.com/productos', lib.UserAuthentify, async(req, res) => {
    try {
        let product = await q.CreatedProduct(req.body);
        res.status(201);
        res.json(product);
    } catch (error) { res.status(400);
        res.json({ error }); }
});
app.patch('/resto.com/productos/:id', lib.UserAuthentify, async(req, res) => {
    try {
        await q.UpdateProduct(req.body.price, req.params.id);
        res.status(200);
        res.json({});
    } catch (error) { res.status(400);
        res.json({ error }); }
});
app.delete('/resto.com/productos/:id', lib.UserAuthentify, async(req, res) => {
    try {
        await q.DeleteProduct(req.params.id);
        res.status(204);
        res.json({});
    } catch (error) { res.status(400);
        res.json({ error }); }
});
//PEDIDOS____________________________________
app.get('/resto.com/mis-pedidos', async(req, res) => {
    try {
        const orders = await q.MyOrders(req.headers.authorization);
        if (orders.length === 0) { res.status(204);
            res.json(orders); } else { res.status(200);
            res.json(orders); }
    } catch (error) { res.status(500);
        res.json({ error }); }
});
app.post('/resto.com/pedidos', async(req, res) => {
    try {
        const bill = await q.NewOrder(req);
        res.status(201);
        res.json(bill);
    } catch (error) { res.status(400);
        res.json({ error }); }
});
app.get('/resto.com/pedidos/', lib.UserAuthentify, async(req, res) => {
    try {
        const orders = await q.Orders();
        if (orders.length === 0) { res.status(204);
            res.json(orders); } else { res.status(200);
            res.json(orders); }
    } catch (error) { res.status(500);
        res.json({ error }); }
});
app.patch('/resto.com/pedidos', lib.UserAuthentify, async(req, res) => {
    try {
        const order = await q.UpdateOrderState(req.body);
        res.status(200);
        res.json(order);
    } catch (error) { res.status(400);
        res.json({ error }); }
});
app.delete('/resto.com/pedidos/:id', lib.UserAuthentify, async(req, res) => {
    try {
        await q.DelecteOrder(req.params.id);
        res.status(204);
        res.json({});
    } catch (error) { res.status(400);
        res.json({ error }); }
});


//Server is Listenning
app.set('port', process.env.PORT || 3000);
app.listen(app.get('port'), console.log('Server on port ', app.get('port')));