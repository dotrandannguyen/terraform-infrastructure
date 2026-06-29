import { useState, useEffect } from 'react'
import axios from 'axios'
import './App.css'

interface SysInfo {
  serverTime: string;
  environment: string;
  version: string;
  services: { id: number; name: string; status: string }[];
}

function App() {
  const [health, setHealth] = useState<string>('Pinging server...')
  const [sysInfo, setSysInfo] = useState<SysInfo | null>(null)

  useEffect(() => {
    // Gọi API Healthcheck
    axios.get('/api/health')
      .then(res => setHealth(res.data.status === 'success' ? '🟢 Online' : '🔴 Offline'))
      .catch(() => setHealth('🔴 Offline'))

    // Gọi API Info
    axios.get('/api/info')
      .then(res => setSysInfo(res.data))
      .catch(err => console.error(err))
  }, [])

  return (
    <div className="dashboard-container">
      <header className="header">
        <h1>AWS Production Dashboard</h1>
        <div className="status-badge">{health}</div>
      </header>

      <main className="main-content">
        {!sysInfo ? (
          <div className="loading-spinner">Loading system data...</div>
        ) : (
          <div className="info-cards">
            <div className="card">
              <h3>System Overview</h3>
              <p><strong>Environment:</strong> <span className="tag">{sysInfo.environment}</span></p>
              <p><strong>Version:</strong> {sysInfo.version}</p>
              <p><strong>Server Time:</strong> {sysInfo.serverTime}</p>
            </div>

            <div className="card">
              <h3>Microservices Status</h3>
              <ul className="service-list">
                {sysInfo.services.map(svc => (
                  <li key={svc.id}>
                    {svc.name}
                    <span className={`badge ${svc.status.toLowerCase()}`}>
                      {svc.status}
                    </span>
                  </li>
                ))}
              </ul>
            </div>
          </div>
        )}
      </main>
    </div>
  )
}

export default App
