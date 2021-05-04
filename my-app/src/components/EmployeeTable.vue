<template>
  <div class="employeetable" style="display:grid;">
    <h1>{{ msg }}</h1>
    <DataTable
    :header-fields="headerFields"
    :data="data"
    />
  </div>
</template>

<script>
import {DataTable} from 'v-datatable-light';
import axios from 'axios';

export default {
  name: 'EmployeeTable',
  props: {
    msg: String
  },
  components: {
    DataTable
  },
  data() {
    return {
      headerFields: ['WWI Employee ID', 'Employee', 'Preferred Name'],
      data: []
    }
  },
  created() {
    axios.get(`/api/display-table`)
    .then(response => {
      // JSON responses are automatically parsed.
      this.data = response.data
    })
    .catch(e => {
      this.errors.push(e)
    })
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
