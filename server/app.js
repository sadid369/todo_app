const express = require("express");
const mongoose = require("mongoose");
const MyTodo = require("./model/todo");
const app = express();
app.use(express.json());
const DB = "mongodb://127.0.0.1:27017/mytodo";

mongoose
  .connect(DB)
  .then(() => {
    console.log("MongoDB Connection Successfully");
  })
  .catch((e) => {
    console.log(e);
  });
app.post("/", async (req, res) => {
  const { todo } = req.body;
  const newTodo = await MyTodo.create({ todo });
  res.json(newTodo);
});
app.patch("/", async (req, res) => {
  const { id, todo } = req.body;
  console.log(id);
  const updatedId = await MyTodo.findByIdAndUpdate(
    id,
    {
      todo,
    },
    { returnDocument: "after" }
  );
  console.log(updatedId);
  res.json(updatedId);
});
app.delete("/", async (req, res) => {
  const { id } = req.body;
  await MyTodo.findByIdAndDelete(id);
});
app.get("/", async (req, res) => {
  const todos = await MyTodo.find();
  res.json(todos);
});
app.listen(8005, () => {
  console.log("Server is Running @port 8005");
});
