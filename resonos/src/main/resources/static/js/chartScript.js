    const ctx = document.getElementById('hexRadarChart').getContext('2d');

    new Chart(ctx, {
      type: 'radar',
      data: {
        labels: ['분위기1', '분위기1', '분위기1', '분위기1', '분위기1', '분위기1'],
        datasets: [{
          label: '스탯',
          data: [80, 60, 70, 90, 50, 85],
          backgroundColor: 'rgba(212, 185, 127, 0.2)',
          borderColor: '#D4B97F',
          pointBackgroundColor: '#D4B97F'
        }]
      },
      options: {
    responsive: true,
    maintainAspectRatio: false,
    scales: {
      r: {
        grid: {
          color: '#D4B97F' // ← 육각형 격자선 하얗게
        },
        angleLines: {
          color: '#D4B97F' // ← 중심에서 뻗는 축선 하얗게
        },
        pointLabels: {
          color: '#D4B97F' // ← 꼭짓점 라벨 텍스트 색
        },
        ticks: {
          stepSize: 25,
          backdropColor: 'transparent'
        },
        min: 0,
        max: 100
      }
    },
    plugins: {
      legend: {
        labels: {
          color: '#D4B97F' // 범례 글자색
        }
      }
    }
  }
});