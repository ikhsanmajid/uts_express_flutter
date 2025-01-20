import express, { Express, Request, Response } from 'express';
import cors from 'cors';
import { apiv1 } from './routes/api';

const app: Express = express();
const port: number = 3000;

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
//app.use(cors())

app.get('/', (req: Request, res: Response) => {
  res.status(200).send('Success');
});

app.use('/api/v1', apiv1);

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});