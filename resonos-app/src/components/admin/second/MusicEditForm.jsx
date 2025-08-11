import React, { useState, useEffect } from 'react';
import FormInput from '../first/FormInput';

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

const MusicEditForm = ({ type, initialData, onSubmit, onCancel }) => {
  const [formData, setFormData] = useState(initialData || {});

  useEffect(() => {
    setFormData(initialData || {});
  }, [initialData]);

  const handleChange = e => {
    const { name, value } = e.target;
    setFormData(prev => ({ ...prev, [name]: value }));
  };
  const handleSubmit = e => {
    e.preventDefault();
    onSubmit(formData);
  };

  return (
    <form className="border rounded p-3 bg-dark text-light" onSubmit={handleSubmit}>
      <div className="row g-2">
        {fieldsMap[type].map((f, idx) => (
          <FormInput
            key={idx}
            label={f.label}
            name={f.name}
            type={f.type || 'text'}
            value={formData[f.name] || ''}
            onChange={handleChange}
            required={f.required}
            containerClassName="col-md-3"
          />
        ))}
      </div>
      <div className="text-end mt-2">
        <button className="btn btn-gold btn-sm" type="submit">저장</button>
        <button type="button" className="btn btn-outline-secondary btn-sm ms-2" onClick={onCancel}>
          취소
        </button>
      </div>
    </form>
  );
};

export default MusicEditForm;
