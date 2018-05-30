<template>
  <v-app>
    <v-toolbar :color="color" dark fixed app>
      <v-toolbar-title>FseFinder</v-toolbar-title>
    </v-toolbar>
    <v-content>
      <v-container fluid>
        <v-layout row wrap>
          <v-flex xs6>
            <v-select
              label="Aircraft Type"
              :items="aircraft_types"
              prepend-icon="airplanemode_active"
              single-line></v-select>
          </v-flex>
        </v-layout>
        <v-data-table
          :headers="headers"
          :items="aircrafts"
          :pagination.sync="pagination">
          <template slot="items" slot-scope="props">
            <td>{{ props.item.registration }}</td>
            <td>{{ props.item.rental_cost_dry | currency }}</td>
            <td>{{ props.item.rental_cost_wet | currency }}</td>
            <td>{{ props.item.distance_bonus | currency }}</td>
            <td>{{ props.item.current_airport }}</td>
            <td>{{ props.item.home_airport }}</td>
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
  export default {
    data () {
      return {
        color: 'indigo',
        fixed: true,
        headers: [
          { text: 'Registration', value: 'registration' },
          { text: 'Rental Cost (Dry)', value: 'rental_cost_dry' },
          { text: 'Rental Cost (Wet)', value: 'rental_cost_wet' },
          { text: 'Distance Bonus', value: 'distance_bonus' },
          { text: 'Current Airport', value: 'current_airport' },
          { text: 'Home Airport', value: 'home_airport' }
        ],
        pagination: {
          sortBy: 'rental_cost_dry'
        },
        aircrafts: [
          {
            registration: 'N137DT',
            rental_cost_dry: 100,
            rental_cost_wet: 0,
            distance_bonus: 203,
            current_airport: 'KVBW',
            home_airport: 'KSHD'
          },
          {
            registration: 'N138DT',
            rental_cost_dry: 200,
            rental_cost_wet: 350,
            distance_bonus: 0,
            current_airport: 'KCLT',
            home_airport: 'KCLT'
          }
        ],
        aircraft_types: [
          { text: 'Cessna 172 Skyhawk', value: 'C172' }
        ]
      }
    }
  }
</script>
