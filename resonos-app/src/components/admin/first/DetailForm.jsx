import React, { useState, useEffect } from 'react';

const DetailForm = ({
  data = {},
  originalData = null,
  onChange = () => {},
  onSubmit = () => {},
  onDelete = () => {},
  onCancel = () => {},
  readOnly = false,
  renderExtra, // (data) => JSX, 폼 하단 추가 영역 렌더링 콜백
}) => {
  // 내부 상태 유지 (필수는 아니며, 원하면 사용)
  const [formState, setFormState] = useState(data);

  // 부모 data 변경시 formState 동기화
  useEffect(() => {
    setFormState(data);
  }, [data]);

  // 입력 변경 처리
  const handleChange = (e) => {
    const { name, value, type, checked } = e.target;
    const val = type === 'checkbox' ? checked : value;

    setFormState(prev => {
      const updated = { ...prev, [name]: val };
      // 부모 콜백 호출 (필드명, 값)
      onChange(name, val);
      return updated;
    });
  };

  // 기본적인 텍스트, 숫자, 체크박스 필드 렌더링
  // 필요시 커스텀 필드를 추가하거나, 특정 키 제외 가능
  const renderField = (key) => {
    const value = formState[key] ?? '';

    // 간단하게 타입 추론 (숫자, boolean, 문자열)
    if (typeof value === 'boolean') {
      return (
        <label key={key} style={{ display: 'block', marginBottom: '8px' }}>
          <input
            type="checkbox"
            name={key}
            checked={value}
            onChange={handleChange}
            disabled={readOnly}
          />{' '}
          {key}
        </label>
      );
    } else if (typeof value === 'number') {
      return (
        <label key={key} style={{ display: 'block', marginBottom: '8px' }}>
          {key}:&nbsp;
          <input
            type="number"
            name={key}
            value={value}
            onChange={handleChange}
            disabled={readOnly}
          />
        </label>
      );
    } else {
      return (
        <label key={key} style={{ display: 'block', marginBottom: '8px' }}>
          {key}:&nbsp;
          <input
            type="text"
            name={key}
            value={value}
            onChange={handleChange}
            disabled={readOnly}
          />
        </label>
      );
    }
  };

  // 변경사항 감지 (선택사항)
  const isChanged = () => {
    if (!originalData) return false;
    // 객체 키 단순 비교
    return Object.keys(formState).some(
      (key) => JSON.stringify(formState[key]) !== JSON.stringify(originalData[key])
    );
  };

  return (
    <div
      style={{
        border: '1px solid #ccc',
        padding: 16,
        marginTop: 16,
        borderRadius: 4,
        backgroundColor: '#f9f9f9',
      }}
    >
      <h3>상세 정보</h3>
      <form
        onSubmit={(e) => {
          e.preventDefault();
          if (readOnly) return;
          onSubmit();
        }}
      >
        {/* 폼 필드 렌더링 */}
        {formState &&
          Object.keys(formState).map((key) => {
            // id나 key 필드는 편집 불가 처리 또는 제외 가능
            if (key === 'id' || key === 'createdAt' || key === 'updatedAt') return null;
            return renderField(key);
          })}

        {/* 커스텀 추가 영역 */}
        {renderExtra && renderExtra(formState)}

        <div style={{ marginTop: 16 }}>
          {!readOnly && (
            <>
              <button type="submit" disabled={!isChanged()} style={{ marginRight: 8 }}>
                저장
              </button>
              <button type="button" onClick={onCancel} style={{ marginRight: 8 }}>
                취소
              </button>
              {onDelete && (
                <button
                  type="button"
                  onClick={onDelete}
                  style={{ backgroundColor: 'red', color: 'white' }}
                >
                  삭제
                </button>
              )}
            </>
          )}

          {readOnly && (
            <button type="button" onClick={onCancel}>
              닫기
            </button>
          )}
        </div>
      </form>
    </div>
  );
};

export default DetailForm;
