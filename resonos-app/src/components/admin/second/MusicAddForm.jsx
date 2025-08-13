import React, { useState, useEffect } from 'react';
import FormInput from '../first/FormInput';
import FormSelect from '../first/FormSelect';

const fieldsMap = {
  track: [
    { name: 'id', label: 'ID', required: true },
    { name: 'title', label: '제목', required: true },
    { name: 'genre', label: '장르' },
    { name: 'albumId', label: '앨범ID' },
    { name: 'artistId', label: '아티스트ID' },
    { name: 'duration', label: '재생시간', type: 'number' },
    { name: 'popularity', label: '인기', type: 'number' },
    { name: 'trackNo', label: '트랙번호', type: 'number' }
  ],
  album: [
    { name: 'id', label: 'ID', required: true },
    { name: 'title', label: '제목', required: true },
    { name: 'coverImage', label: '커버 이미지 URL' },
    { name: 'releaseDate', label: '발매일' },
    { name: 'genre', label: '장르' },
    { name: 'label', label: '레이블' },
    { name: 'description', label: '설명' },
    { name: 'artistId', label: '아티스트ID' }
  ],
  artist: [
    { name: 'id', label: 'ID', required: true },
    { name: 'name', label: '이름', required: true },
    { name: 'profileImage', label: '프로필 이미지 URL' },
    { name: 'genres', label: '장르(쉼표구분)' }
  ]
};

const MusicAddForm = ({ type = 'track', initialData = {}, onSubmit, onCancel }) => {
  // 필드 기본 구조
  const initialState = fieldsMap[type].reduce((acc, f) => {
    acc[f.name] = '';
    return acc;
  }, {});

  // 초기값 + 전달받은 initialData 합치기
  const [formData, setFormData] = useState({ ...initialState, ...initialData });

  // initialData가 바뀌면 state 갱신
    useEffect(() => {
    // 수정 모드일 때만 기존 데이터로 세팅
    if (initialData && Object.keys(initialData).length > 0) {
        setFormData({ ...initialState, ...initialData });
    }
    }, [type, initialData]);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData(prev => ({ ...prev, [name]: value }));
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    onSubmit(formData);
  };

  const handleCancel = () => {
    setFormData({ ...initialState, ...initialData }); // 취소 시 원래 값 복원
    onCancel();
  };

  return (
    <form className="resonos-card p-3 bg-resonos-dark rounded-3 mb-4" onSubmit={handleSubmit}>
      <div className="row g-2">
        {fieldsMap[type].map((f, idx) => (
          <FormInput
            key={idx}
            label={f.label}
            name={f.name}
            type={f.type || 'text'}
            value={formData[f.name]}
            onChange={handleChange}
            required={f.required}
            containerClassName="col-md-3"
          />
        ))}
      </div>
      <div className="text-end mt-2">
        <button className="btn btn-gold btn-sm" type="submit">저장</button>
        <button type="button" className="btn btn-outline-secondary btn-sm ms-2" onClick={handleCancel}>
          취소
        </button>
      </div>
    </form>
  );
};

export default MusicAddForm;
