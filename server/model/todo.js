const mongoose = require("mongoose");

const todoSchema = mongoose.Schema({
  todo: {
    type: String,
    required: true,
  },
});

const MyTodo = mongoose.model("MyTodo", todoSchema);

module.exports = MyTodo;
