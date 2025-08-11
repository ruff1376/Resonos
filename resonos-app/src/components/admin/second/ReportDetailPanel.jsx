import React from 'react';

const ReportDetailPanel = ({ report, onStatusChange, onDelete }) => {
  if (!report) return null;

  return (
    <div className="p-3 border border-secondary rounded bg-dark text-light mb-3">
      <h5 className="text-light-gold mb-3">신고 상세 정보</h5>

      <div className="row">
        <div className="col-md-6 text-start">
          <p><strong>신고 ID:</strong> {report.id}</p>
          <p>
            <strong>유형:</strong> {report.targetType}
            {report.targetType === 'boardPost' && (
              <a href={`/posts/${report.targetId}`} target="_blank" rel="noreferrer" className="btn btn-outline-gold btn-xs ms-2">게시글 바로가기</a>
            )}
            {report.targetType === 'comment' && (
              <a href={`/comments/${report.targetId}`} target="_blank" rel="noreferrer" className="btn btn-outline-gold btn-xs ms-2">댓글 바로가기</a>
            )}
            {report.targetType === 'user' && (
              <a href={`/users/${report.targetId}`} target="_blank" rel="noreferrer" className="btn btn-outline-gold btn-xs ms-2">유저 프로필</a>
            )}
            {report.targetType === 'review' && (
              <a href={`/reviews/${report.targetId}`} target="_blank" rel="noreferrer" className="btn btn-outline-gold btn-xs ms-2">리뷰 바로가기</a>
            )}
          </p>
          <p><strong>대상 ID:</strong> {report.targetId}</p>
          <p><strong>사유:</strong> {report.reason}</p>
        </div>

        <div className="col-md-6 text-start">
          <p><strong>신고자:</strong> {report.reporterId}</p>
          <p><strong>신고일시:</strong> {report.createdAt}</p>
          <p><strong>상태:</strong> {report.status}</p>
          <p><strong>처리자:</strong> {report.processedBy || '-'}</p>
          {report.processedAt && (
            <p><strong>처리일시:</strong> {report.processedAt}</p>
          )}
          {report.processMemo && (
            <p><strong>처리메모:</strong> {report.processMemo}</p>
          )}
        </div>
      </div>

      {/* 상태 변경 */}
      <div className="mt-3 text-end">
        <select
          className="form-select form-select-sm d-inline-block w-auto me-2"
          value={report.status}
          onChange={(e) => onStatusChange(report.id, e.target.value)}
        >
          <option value="PENDING">대기</option>
          <option value="PROCESSED">처리</option>
          <option value="REJECTED">기각</option>
        </select>
        <button
          className="btn btn-outline-danger btn-sm"
          onClick={() => onDelete(report.id)}
        >
          삭제
        </button>
      </div>
    </div>
  );
};

export default ReportDetailPanel;
