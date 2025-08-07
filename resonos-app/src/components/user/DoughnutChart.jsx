import React, { useRef, useEffect } from 'react';
import Chart from 'chart.js/auto';

const colorList = [
  '#82B8FF', '#FF9F82', '#82FFB8', '#FF82D1', '#FFD682', '#8C82FF',
  '#82D1FF', '#FFB982', '#82FFC9', '#FF82B3', '#FFE082', '#9B82FF',
  '#FF6F61', '#4DB6AC', '#FFCA28', '#6A1B9A', '#00897B', '#D81B60',
  '#F4511E', '#558B2F'
];

const DoughnutChart = ({ chartData }) => {
  const canvasRef = useRef(null);
  const chartInstanceRef = useRef(null);

  useEffect(() => {
    if (!chartData || typeof chartData !== 'object') return;

    const labels = Object.keys(chartData);
    const data = Object.values(chartData);

    const ctx = canvasRef.current.getContext('2d');

    // 기존 차트 제거
    if (chartInstanceRef.current) {
      chartInstanceRef.current.destroy();
    }

    // 새 차트 생성
    chartInstanceRef.current = new Chart(ctx, {
      type: 'doughnut',
      data: {
        labels: labels,
        datasets: [{
          label: ' ',
          data: data,
          backgroundColor: colorList.slice(0, labels.length),
          borderWidth: 1
        }]
      },
      options: {
        layout: {
          padding: {
            right: -10
          }
        },
        responsive: false,
        maintainAspectRatio: false,
        plugins: {
          legend: {
            labels: {
              boxWidth: 15,
              boxHeight: 15
            },
            position: 'right'
          },
          title: {
            display: false,
            position: 'left',
            text: '장르 선호 차트',
            color: '#D4B97F',
            padding: {
              bottom: 15,
              right: 30
            },
            font: {
              size: 18
            }
          }
        }
      }
    });

    // cleanup
    return () => {
      if (chartInstanceRef.current) {
        chartInstanceRef.current.destroy();
      }
    };
  }, [chartData]);

  return <canvas ref={canvasRef} width={300} height={300} />
};

export default DoughnutChart;
