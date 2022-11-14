import * as ReactDOM from 'react-dom'
import * as React from 'react'
import {serialize} from 'object-to-formdata';
import md5 from "md5";
import {useState} from 'react';

const MAX_COUNT = 5;
const Upload = () => {

  const [uploadedFiles, setUploadedFiles] = useState([])
  const [fileLimit, setFileLimit] = useState(false);

  const handleUploadFiles = files => {
    const uploaded = [...uploadedFiles];
    let limitExceeded = false;

    files.some((file) => {
      if (uploaded.findIndex((f) => f.name === file.name) === -1) {
        readFile(file).then((result) => {
          file["content"] = result;
          console.log('aqui!')
        })

        uploaded.push({file: file, checksum: md5(file.name)});
        console.log(uploaded)
        if (uploaded.length === MAX_COUNT) setFileLimit(true);
        if (uploaded.length > MAX_COUNT) {
          alert(`You can only add a maximum of ${MAX_COUNT} files`);
          setFileLimit(false);
          limitExceeded = true;
          return true;
        }
      }
    })

    if (!limitExceeded) {
      console.log(uploaded)
      setUploadedFiles(uploaded)
    }
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
    const chosenFiles = Array.prototype.slice.call(e.target.files)
    handleUploadFiles(chosenFiles);
  }

  const formatUpload = () => {
    let uploadList = []
    for (var key in uploadedFiles) {
      let data_info = uploadedFiles[key]
      uploadList.push({
        file: data_info.file.content,
        file_name: data_info.file.name,
        byte_size: data_info.file.size,
        content_type: data_info.file.type,
        checksum: data_info.checksum,
        metadata: {message: "active_storage_test"}
      })
    }


    return uploadList
  }

  const onSubmit = (e) => {
    e.preventDefault()
    const options = {
      indices: true, nullsAsUndefineds: false, booleansAsIntegers: false, allowEmptyArrays: false,
      noFilesWithArrayNotation: false, dotsForObjectNotation: false
    };

    const body = serialize(formatUpload(), options)
    const config = {
      headers: {
        Accept: 'application/json',
        'Content-Type': 'multipart/form-data',
      }
    };

    fetch(`http://localhost:3000/uploads`, {method: "POST", body: body, config})
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
            <input id='title' type='text' name='title'/>
          </div>

          <hr/>

          <div>
            <input id='fileUpload' type='file' multiple accept='application/pdf, image/png' onChange={handleFileEvent}
                   disabled={fileLimit}/>
            <label htmlFor='fileUpload'>
              <a className={`upload-body btn btn-primary ${!fileLimit ? '' : 'disabled'} `}>Upload Files</a>
            </label>
          </div>

          <div className="uploaded-files-list">
            <ul>
              {uploadedFiles.map(file => (
                <li key={file.file.name}>
                  {file.file.name}
                </li>
              ))}
            </ul>
          </div>
          <button>Send</button>
        </fieldset>
      </form>
    </div>
  );
}

export default Upload