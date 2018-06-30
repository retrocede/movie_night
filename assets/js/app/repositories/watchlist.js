import axios from 'axios';

export function getWatchlist() {
    return axios.get('/api/movies');
}