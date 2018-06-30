import axios from 'axios';

export function searchForMovie(search, page) {
    var query = encodeURIComponent(search);

    return axios.get('/api/search', {
        params: {
            query,
            page,
        }
    });
}