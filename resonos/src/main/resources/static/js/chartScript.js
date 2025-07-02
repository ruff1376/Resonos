    const ctx = document.getElementById('hexRadarChart').getContext('2d');

    new Chart(ctx, {
      type: 'radar',
      data: {
        labels: ['힘', '속도', '지구력', '지능', '운', '반사신경'],
        datasets: [{
          label: '스탯',
          data: [80, 60, 70, 90, 50, 85],
          backgroundColor: 'rgba(255, 99, 132, 0.2)',
          borderColor: 'rgba(255, 99, 132, 1)',
          pointBackgroundColor: 'rgba(255, 99, 132, 1)'
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        scales: {
          r: {
            min: 0,
            max: 100,
            ticks: {
              stepSize: 20
            }
          }
        }
      }
    });