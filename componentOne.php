<div id="app">
    <script src="vue.js"></script>
    <p>Inserting item to List</p>
    <ol>
        <p>ID : <input type="text" v-on:Input="texttoId"></p>
        <p>Name : <input type="text" v-on:Input="texttoName"></p>
        <button v-on:click="InsertItem"> Insert </button>
        <list-Item v-for="items in DanhSach" v-bind:lists="items" v-bind:key="items.id">>
        </list-Item>
    </ol>
</div>

<script>
Vue.component('list-item',{
    props: ['lists'],
    template:'<li>ID : {{key}} - Name : {{lists.text}}</li>'
})
new Vue({
    el: '#app',
    data: {
        textId : '',
        textName : '',
        DanhSach : [
            {id:0 ,text: 'Hi'}
        ],
    },
    methods : {
        texttoId: function(event){
            this.textId = event.target.value;
        },
        texttoName: function(event){
            this.textName = event.target.value;
        },
        InsertItem: function(){
            this.DanhSach.push({id:this.textId,text:this.textName})
        }
    },
})
</script>