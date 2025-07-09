document.addEventListener('DOMContentLoaded', function () {
    document.querySelectorAll('.doughnut-canvas').forEach((canvas, index) => {
        const value = 40; // 예시용 값 — 이 부분은 실제 데이터로 바꿔도 됩니다

        // 색상 조건
        let color;
        if (value >= 70) {
            color = '#4CAF50'; // 초록
        } else if (value >= 50) {
            color = '#FFC107'; // 노랑
        } else {
            color = '#F44336'; // 빨강
        }

        const ctx = canvas.getContext('2d');

        // ✅ 첫 번째일 경우: 큰 폰트
        const isFirst = canvas.dataset.first === "true";
        const fontSize = isFirst ? 20 : 14; // px 기준 폰트 크기 조절

        // 중앙 텍스트 플러그인
        const centerTextPlugin = {
            id: 'centerText',
            afterDraw(chart) {
                const { ctx, chartArea: { width, height } } = chart;
                ctx.save();
                ctx.font = `bold ${fontSize}px sans-serif`;
                ctx.fillStyle = color;
                ctx.textAlign = 'center';
                ctx.textBaseline = 'middle';
                ctx.fillText(value, width / 2, height / 2);
                ctx.restore();
            }
        };

        new Chart(ctx, {
            type: 'doughnut',
            data: {
                datasets: [{
                    data: [value, 100 - value],
                    backgroundColor: [color, 'white'],
                    borderWidth: 0
                }]
            },
            options: {
                responsive: false,
                cutout: '70%',
                plugins: {
                    tooltip: { enabled: false },
                    legend: { display: false }
                }
            },
            plugins: [centerTextPlugin]
        });
    });
});