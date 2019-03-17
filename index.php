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
    </div>
</body>
<script>
    new Vue({
        el:'#app',
        data: {
            noidung : 'Trung Hiếu đẹp trai'
        },
        methods: {
            Nhaptext: function(event){
                this.noidung = event.target.value;
            }
        },
    })
</script>
</html>