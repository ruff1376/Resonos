import { useEffect, useRef } from 'react';
import { Chart, registerables } from 'chart.js';



export default function useRadarChart(canvasRef, argValues, isArgEmpty) {
    const chartInstanceRef = useRef(null);

    useEffect(() => {
        if (isArgEmpty || !canvasRef.current || !argValues || Object.keys(argValues).length === 0) {
            if (chartInstanceRef.current) {
                chartInstanceRef.current.destroy();
                chartInstanceRef.current = null;
            }
            return;
        }

        const ctx = canvasRef.current.getContext('2d');

        if (chartInstanceRef.current) {
            chartInstanceRef.current.destroy();
        }

        const labels = Object.keys(argValues);
        const values = Object.values(argValues);

        const maxValue = Math.max(...values);
        const roundedMax = Math.ceil(maxValue / 10) * 10 || 100;

        chartInstanceRef.current = new Chart(ctx, {
            type: 'radar',
            data: {
                labels: labels,
                datasets: [{
                    label: '평균 점수',
                    data: values,
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
                        grid: { color: '#D4B97F' },
                        angleLines: { color: '#D4B97F' },
                        pointLabels: {
                            color: '#D4B97F',
                            font: { size: 16, weight: 'bold' }
                        },
                        ticks: {
                            stepSize: 20,
                            backdropColor: 'transparent'
                        },
                        min: 0,
                        max: 100
                        }
                    },
                    plugins: { legend: { display: false } }
                }
            });

        return () => {
            if (chartInstanceRef.current) {
                chartInstanceRef.current.destroy();
                chartInstanceRef.current = null;
            }
        };
    }, [canvasRef, argValues, isArgEmpty]);
}