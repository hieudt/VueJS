<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Using test VueJS</title>
</head>

<body>
    <script src="vue.js"></script>
    <div id="app">
        <input type="text" name="" id="" v-on:input="Nhaptext">
        {{noidung}}
        <a v-bind:href="link">On mouse : {{link}}</a>

        <span v-if="seen">Helloworld</span> <br>

        u touch : {{touch}} times ! 
        <button v-on:click="touchButton">Click me</button> <br>


        <h1>First code 1</h1>
        <input type="text" v-on:input="textToInp">
        <button v-on:click="insertTodo">Insert</button>
        <ol>
            <li v-for="todo in todos">
                {{todo.text}}
            </li>
        </ol>
    </div>
</body>
<script>
    new Vue({
        el: '#app',
        data: {
            noidung: 'Trung Hiếu đẹp trai',
            link: 'http://facebook.com/bossgin.vhb',
            seen:true,
            touch : 0,
            textTodo : '',
            todos: [ ],
        },
        methods: {
            Nhaptext: function(event) {
                this.noidung = event.target.value;
            },

            textToInp: function(event){
                this.textTodo = event.target.value;
            },

            insertTodo: function(){
                this.todos.push({text: this.textTodo}) 
            },

            touchButton: function(){
                this.touch++;
            }
        },
    })

    
</script>

</html> 