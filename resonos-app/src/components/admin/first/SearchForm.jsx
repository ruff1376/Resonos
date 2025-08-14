import React, { useState, useEffect } from 'react';

const SearchForm = ({
  initialKeyword = '',
  placeholder = '검색어를 입력하세요',
  buttonLabel = '검색',
  onSearch,
}) => {
  const [keyword, setKeyword] = useState(initialKeyword);

  // 부모에서 initialKeyword 변경 시 내부 상태 동기화
  useEffect(() => {
    setKeyword(initialKeyword);
  }, [initialKeyword]);

  const handleSubmit = (e) => {
    e.preventDefault();
    onSearch(keyword.trim());
  };

return (
  <form className="admin mb-3 d-flex gap-2" onSubmit={handleSubmit}>
    <input
      type="text"
      className="form-control search-bar"
      placeholder={placeholder}
      value={keyword}
      onChange={(e) => setKeyword(e.target.value)}
    />
    <button className="btn btn-gold btn-sm" type="submit">
      {buttonLabel}
    </button>
  </form>
);

};

export default SearchForm;
