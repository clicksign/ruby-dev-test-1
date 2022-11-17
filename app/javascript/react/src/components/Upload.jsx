import * as React from 'react'
import {serialize} from 'object-to-formdata';
import {useState} from 'react';

const Upload = () => {

  let [uploadContent, setUploadedFiles] = useState({ title: '', info: { path: '', files: [] }})

  const handleUploadFiles = (uploadFiles) => {
    uploadFiles.info.files.some((file) => {
      readFile(file).then((result) => {
        file['data'] = result;
      })
    })

    setUploadedFiles(uploadFiles)
  }

  const readFile = async (eFile) => {
    return new Promise((resolve, reject) => {
      let fileReader = new FileReader();
      fileReader.onload = () => {
        resolve(fileReader.result);
      };
      fileReader.onerror = reject;
      fileReader.readAsDataURL(eFile);
    });
  }

  const handleFileEvent = (e) => {
    uploadContent = {title: '', info: { path: '', files: Array.prototype.slice.call(e.target.files) }}
    handleUploadFiles(uploadContent);
  }

  const onSubmit = (e) => {
    e.preventDefault()

    uploadContent.title = e.target[1].value
    uploadContent.info.path = e.target[2].value

    const options = {
      indices: true, nullsAsUndefineds: false, booleansAsIntegers: false, allowEmptyArrays: false,
      noFilesWithArrayNotation: false, dotsForObjectNotation: false
    };

    const body = serialize({ upload: uploadContent, options })
    const config = {
      headers: {
        Accept: 'application/json',
        'Content-Type': 'multipart/form-data',
      }
    };

    console.log(uploadContent);
    fetch(`http://localhost:3000/uploads`,
      { method: "POST", body: body, config
      }).then((result) => {
      setUploadedFiles({ title: '', info: { path: '', files: [] }})
    })
  }

  return (
    <div className="Upload">
      <form onSubmit={onSubmit}>
        <fieldset>
          <legend>Add Files</legend>

          <div>
            <label htmlFor='title'>
              title for this upload
            </label>
            <input id='title' type='text' name='title' required/>
          </div>

          <hr/>

          <div>
            <label htmlFor='title'>
              select a path to upload
            </label>
            <select id='path_upload' name='path upload' required>
              <option value="">choose</option>
              <option value="foo/path/one">path one</option>
              <option value="foo/path/two">path two</option>
              <option value="foo/path/three">path three</option>
            </select>
          </div>

          <hr/>

          <div>
            <input id='fileUpload' type='file' multiple accept='application/pdf, image/png' onChange={handleFileEvent}/>
            <label htmlFor='fileUpload'>
              <a className='upload-body btn btn-primary'>Upload Files</a>
            </label>
          </div>

          <div className="uploaded-files-list">
            <ul>
              {
                uploadContent.info.files.map(file => (
                  <li key={file.name}>
                    {file.name}
                  </li>
                ))
              }
            </ul>
          </div>
          <button>Send</button>
        </fieldset>
      </form>
    </div>
  );
}

export default Upload