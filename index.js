const express = require('express');
const fs = require('fs');
const path = require('path');
const app = express();
const port = process.env.PORT || 3000;

app.get('/', (req, res) => {
  let terraformStatus = 'Provisioning...';
  let infrastructure = {};

  try {
    const resultsPath = path.join(__dirname, 'terraform', 'terraform_results.json');
    if (fs.existsSync(resultsPath)) {
      const results = JSON.parse(fs.readFileSync(resultsPath, 'utf8'));
      infrastructure = results;
      terraformStatus = 'Ready';
    }
  } catch (err) {
    console.error('Error reading terraform results:', err);
  }

  res.json({
    message: 'Hello ChuZone!',
    version: '1.0.0',
    status: 'Ready',
    environment: 'POC',
    phase: 'CD Phase 3 - Successfully Deployed',
    infrastructure: {
      status: terraformStatus,
      details: infrastructure
    }
  });
});

app.get('/health', (req, res) => {
  res.status(200).json({ status: 'ok' });
});

if (require.main === module) {
  app.listen(port, () => {
    console.log(`ChuZone POC app listening at http://localhost:${port}`);
  });
}

module.exports = app;
