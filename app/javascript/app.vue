<template>
  <v-app>
    <v-toolbar :color="color" dark fixed app>
      <v-toolbar-title>FseFinder</v-toolbar-title>
    </v-toolbar>
    <v-content>
      <v-container fluid>
        <v-layout row wrap>
          <v-flex xs4>
            <v-select
              label="Aircraft Model"
              :items="aircraft_models"
              v-model="selected_model"
              :loading="aircraft_models_loading"
              prepend-icon="airplanemode_active"
              single-line
              autocomplete
              v-on:change="selectAircraftModel"
            ></v-select>
          </v-flex>
          <v-flex xs4 offset-xs4>
            <!-- TODO: change this to within a v-card so we can add a filter button -->
            <!-- https://material.io/design/components/data-tables.html?image=https%3A%2F%2Fmaterial.io%2Fdesign%2Fassets%2F0B3wFuHgbfPkzanpfajUxbDk1Z00%2Fcomponents-datatables-card1.png#tables-within-cards -->
            <v-switch label="Rentable Only" v-model="rentable_only" hide-details></v-switch>
          </v-flex>
        </v-layout>
        <v-data-table
          :headers="headers"
          :items="aircrafts"
          :loading="aircrafts_loading"
          :pagination.sync="pagination"
          search=""
          :customFilter="customFilter">
          <template slot="items" slot-scope="aircraft">
            <tr @click="aircraft.expanded = !aircraft.expanded">
              <td>{{ aircraft.item.registration }}</td>
              <td>{{ aircraft.item.rental_cost_dry | currency }}</td>
              <td>{{ aircraft.item.rental_cost_wet | currency }}</td>
              <td>{{ aircraft.item.distance_bonus | currency }}</td>
              <td><a v-bind:href="fseAirportLink(aircraft.item.current_airport_id)" target="_blank">{{ aircraft.item.current_airport_id }}</a></td>
              <td><a v-bind:href="fseAirportLink(aircraft.item.home_airport_id)" target="_blank">{{ aircraft.item.home_airport_id }}</a></td>
            </tr>
          </template>
          <template slot="expand" slot-scope="aircraft">
            <v-card flat class="green lighten-3">
              <v-card-text>
                <span><b>Owner:</b> {{ aircraft.item.owner }}</span>
                <span><b>Equipment:</b> {{ aircraft.item.equipment }}</span>
              </v-card-text>
            </v-card>
          </template>
        </v-data-table>
      </v-container>
    </v-content>
    <v-footer class="pa-3" :color="color" dark :fixed="fixed" app>
      <span>&copy; 2018</span>
      <v-spacer></v-spacer>
      <transition name="fade">
        <span v-if="selected_model">
          {{ selected_model.name }} {{ selected_model.last_fse_update ? 'was' : 'was never' }} updated from FSE {{ selected_model.last_fse_update | moment("from") }}
          <v-btn small color="info"
            :disabled="aircrafts_loading"
            @click.native="refreshAircraftModel()"
          >
            Refresh
          </v-btn>
        </span>
      </transition>
    </v-footer>
  </v-app>
</template>

<script>
  import axios from 'axios';

  export default {
    data () {
      return {
        csrf: document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
        color: 'green darken-1',
        fixed: true,
        headers: [
          { text: 'Registration', value: 'registration' },
          { text: 'Rental Cost (Dry)', value: 'rental_cost_dry' },
          { text: 'Rental Cost (Wet)', value: 'rental_cost_wet' },
          { text: 'Distance Bonus', value: 'distance_bonus' },
          { text: 'Current Airport', value: 'current_airport', sortable: false },
          { text: 'Home Airport', value: 'home_airport', sortable: false }
        ],
        pagination: {
          rowsPerPage: 10,
          sortBy: 'rental_cost_dry'
        },
        aircrafts: [],
        aircraft_models: [],
        aircrafts_loading: false,
        aircraft_models_loading: true,
        selected_model: null,
        rentable_only: true
      }
    },
    methods: {
      customFilter (items, search, filter) {
        return items.filter(item => item.rentable === this.rentable_only);
      },
      fseAirportLink (icao_code) {
        return 'http://server.fseconomy.net/airport.jsp?icao=' + icao_code;
      },
      refreshAircraftModel () {
        this.aircrafts_loading = true;
        axios
          .post('aircraft_models/' + this.selected_model.icao_code + '/aircrafts/import.json')
          .then(response => {
            this.selected_model.last_fse_update = response.data.aircraft_model.last_fse_update;
            this.aircrafts = response.data.aircrafts;
            this.aircrafts_loading = false;
          })
          .catch(error => {
            console.log(error);
            this.aircrafts_loading = false;
          });
      },
      selectAircraftModel (model) {
        this.aircrafts_loading = true;
        this.aircrafts = [];
        axios
          .get('aircraft_models/' + model.icao_code + '/aircrafts.json')
          .then(response => {
            this.aircrafts = response.data;
            this.aircrafts_loading = false;
          })
          .catch(error => {
            console.log(error);
            this.aircrafts_loading = false;
          });
      }
    },
    mounted () {
      axios.defaults.headers.post['X-CSRF-Token'] = this.csrf;
      axios
        .get('aircraft_models.json')
        .then(response => {
          this.aircraft_models = response.data.map(aircraft => {
            return {
              text: aircraft.name + ' - ' + aircraft.icao_code,
              value: aircraft
            };
          }).sort((a,b) => a.text > b.text);
        })
        .catch(error => console.log(error))
        .finally(this.aircraft_models_loading = false);
    }
  }
</script>

<style lang="scss" scoped>
  td a {
    text-decoration: none;
  }
  .fade-enter-active, .fade-leave-active {
    transition: opacity .5s;
  }
  .fade-enter, .fade-leave-to /* .fade-leave-active below version 2.1.8 */ {
    opacity: 0;
  }
</style>
