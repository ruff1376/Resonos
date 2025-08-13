import { useEffect, useRef } from 'react';
import {
    Chart,
    RadialLinearScale,
    PointElement,
    LineElement,
    Filler,
    Tooltip,
    Legend
} from 'chart.js';



export default function useRadarChart(canvasRef, argValues, isArgEmpty) {
    const chartInstanceRef = useRef(null);
    useEffect(() => {
        console.log('Chart 객체:', Chart)
        // 2. Chart.js에 모듈을 수동으로 등록
        Chart.register(
            RadialLinearScale,
            PointElement,
            LineElement,
            Filler,
            Tooltip,
            Legend
        );
        console.log('Chart 객체:', Chart)
        if (!canvasRef.current) {
            return;
        }
        // 1. 차트가 그려질 필요가 없는 조건
        if (isArgEmpty || !argValues || Object.keys(argValues).length === 0) {
            // 기존 차트가 있다면 파괴하는 로직은 유효합니다.
            if (chartInstanceRef.current) {
                chartInstanceRef.current.destroy();
                chartInstanceRef.current = null;
            }
            return;
        }

        const ctx = canvasRef.current.getContext('2d');

        // 2. data를 동적으로 생성
        const labels = Object.keys(argValues); // argValues의 키를 라벨로 사용
        const values = Object.values(argValues); // argValues의 값을 데이터로 사용

        // 3. 차트 인스턴스 생성 또는 업데이트
        if (chartInstanceRef.current) {
            // 이미 차트 인스턴스가 존재하면 업데이트 로직
            chartInstanceRef.current.data.labels = labels;
            chartInstanceRef.current.data.datasets[0].data = values;
            chartInstanceRef.current.update();
        } else {
            // 새로운 차트 인스턴스 생성
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
                                backdropColor: 'transparent',
                                color: '#D4B97F'
                            },
                            min: 0,
                            max: 100
                        }
                    },
                    plugins: {
                        legend: { display: false }
                    }
                }
            });
        }

        // 4. 클린업 함수에서만 destroy 호출
        return () => {
            if (chartInstanceRef.current) {
                chartInstanceRef.current.destroy();
                chartInstanceRef.current = null;
            }
        };

    }, [argValues, isArgEmpty, canvasRef]); // 의존성 배열에 argValues와 isArgEmpty를 포함
}