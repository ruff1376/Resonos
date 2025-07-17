const stompClient = Stomp.over(new SockJS("/ws-alarm"));
stompClient.connect({}, function(frame) {
    stompClient.subscribe(`/queue/notify-user-` + userId, function(message) {
        const noti = JSON.parse(message.body);
        showNotification(noti); // UI에 즉시 반영
    });
    stompClient.subscribe('/topic/notice', function(message) {
        const notice = JSON.parse(message.body);
        showNotice(notice);
    });
});
