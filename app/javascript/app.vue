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
              :loading="aircraft_models_loading"
              prepend-icon="airplanemode_active"
              single-line
              autocomplete
              v-on:change="selectAircraftModel"
            ></v-select>
          </v-flex>
        </v-layout>
        <v-data-table
          :headers="headers"
          :items="aircrafts"
          :loading="aircrafts_loading"
          :pagination.sync="pagination">
          <template slot="items" slot-scope="aircraft">
            <td>{{ aircraft.item.registration }}</td>
            <td>{{ aircraft.item.rental_cost_dry | currency }}</td>
            <td>{{ aircraft.item.rental_cost_wet | currency }}</td>
            <td>{{ aircraft.item.distance_bonus | currency }}</td>
            <td><a v-bind:href="fseAirportLink(aircraft.item.current_airport_id)" target="_blank">{{ aircraft.item.current_airport_id }}</a></td>
            <td><a v-bind:href="fseAirportLink(aircraft.item.home_airport_id)" target="_blank">{{ aircraft.item.home_airport_id }}</a></td>
          </template>
        </v-data-table>
      </v-container>
    </v-content>
    <v-footer :color="color" dark :fixed="fixed" app>
      <span>&copy; 2018</span>
    </v-footer>
  </v-app>
</template>

<script>
  import axios from 'axios';

  export default {
    data () {
      return {
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
        aircraft_models_loading: true
      }
    },
    methods: {
      fseAirportLink (icao_code) {
        return 'http://server.fseconomy.net/airport.jsp?icao=' + icao_code;
      },
      selectAircraftModel (event) {
        this.aircrafts_loading = true;
        axios
          .get('aircraft_models/' + event + '/aircrafts')
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
      axios
        .get('aircraft_models')
        .then(response => {
          this.aircraft_models = response.data.map(aircraft => {
            return {
              text: aircraft.name + ' - ' + aircraft.icao_code,
              value: aircraft.icao_code
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
</style>
