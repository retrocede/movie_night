import axios from 'axios';

export function getWatchlist() {
    return axios.get('/api/movies');
}

export function updateMovieStatus(movie, status) {
    return axios.put(`/api/movies/${ movie.id }`, {
        movie: {
            ...movie,
            status
        },
    });
}

export function removeMovie(movie) {
    return axios.delete(`/api/movies/${ movie.id }`);
}

export function addMovie(id) {
    return axios.post('/api/movies', {
        id
    });
}