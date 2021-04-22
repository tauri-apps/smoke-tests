<template>
  <q-page class="flex flex-center column">
    <h4 class="row text-center">Node: {{ nodeMsg }}</h4>
    <h3 class="row text-center">{{ msg }}</h3>
    <div class="row">
      <q-btn @click="eventToRust()">SEND MSG</q-btn>
    </div>
  </q-page>
</template>

<script>
import { uid } from 'quasar'
import { listen, emit } from '@tauri-apps/api/event'

export default {
  name: 'HelloWorld',
  data () {
    return {
      msg: 'waiting for rust',
      nodeMsg: 'waiting'
    }
  },
  mounted () {
    listen('reply', res => {
      this.msg = res.payload.msg
    })
    listen('node', res => {
      this.nodeMsg = res.payload
    })
  },
  methods: {
    // set up an event listener
    eventToRust () {
      emit('hello', uid())
    }
  }
}
</script>
