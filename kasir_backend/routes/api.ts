import { Router } from 'express';
import * as kasirv1 from './v1/kasir';
import { handleError } from '../middleware/handleError';

const api: Router = Router();

api.use('/v1/kasir', kasirv1.barang);

api.use(handleError);

export default api;