import express, { Request, Response } from 'express';
import cors from 'cors';
import dotenv from 'dotenv';

dotenv.config();

const app = express();
const port = process.env.PORT || 3000;

// Cấu hình Middleware
app.use(cors());
app.use(express.json());

// Endpoint chính: Healthcheck cho AWS ALB
app.get('/api/health', (req: Request, res: Response) => {
  res.status(200).json({
    status: 'success',
    message: 'Backend is healthy',
    timestamp: new Date().toISOString()
  });
});

app.get('/api', (req: Request, res: Response) => {
  res.status(200).json({
    message: 'Welcome to the Fullstack AWS Project API!'
  });
});

// Endpoint mô phỏng dữ liệu hệ thống để test UI
app.get('/api/info', (req: Request, res: Response) => {
  const mockInfo = {
    environment: process.env.NODE_ENV || 'PRODUCTION',
    version: '2.0.0',
    timestamp: new Date().toISOString(),
    services: [
      { id: 1, name: 'User Service', status: 'Running' },
      { id: 2, name: 'Payment Service', status: 'Running' },
      { id: 3, name: 'Notification Service', status: 'Warning' }
    ]
  };
  
  // Fake delay 500ms để thấy hiệu ứng loading trên FE
  setTimeout(() => res.json(mockInfo), 500);
});

// Khởi động server
app.listen(port, () => {
  console.log(`🚀 Backend server is running at http://localhost:${port}`);
});
