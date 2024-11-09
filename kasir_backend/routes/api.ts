import { Router } from 'express';
import * as kasirv1 from './v1/kasir';
import { handleError } from '../middleware/handleError';

export const apiv1: Router = Router();

apiv1.use('/kasir', kasirv1.kasir);

apiv1.use(handleError);